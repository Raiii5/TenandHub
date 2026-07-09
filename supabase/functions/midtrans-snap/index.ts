import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const MIDTRANS_SERVER_KEY = Deno.env.get("MIDTRANS_SERVER_KEY") ?? "";

serve(async (req: Request) => {
  const headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers":
      "authorization, x-client-info, apikey, content-type",
  };

  if (req.method === "OPTIONS") {
    return new Response("ok", { headers });
  }

  try {
    const { order_id, gross_amount, item_name, customer_name, customer_email } =
      await req.json();

    const base64ServerKey = btoa(`${MIDTRANS_SERVER_KEY}:`);

    const payload = {
      transaction_details: {
        order_id: order_id,
        gross_amount: gross_amount,
      },
      item_details: [
        {
          id: "BOOTH-TENANT",
          price: gross_amount,
          quantity: 1,
          name: item_name,
        },
      ],
      customer_details: {
        first_name: customer_name,
        email: customer_email,
      },
    };

    const response = await fetch(
      "https://app.sandbox.midtrans.com/snap/v1/transactions",
      {
        method: "POST",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
          Authorization: `Basic ${base64ServerKey}`,
        },
        body: JSON.stringify(payload),
      },
    );

    const data = await response.json();

    return new Response(JSON.stringify(data), {
      headers: { ...headers, "Content-Type": "application/json" },
      status: 200,
    });
  } catch (error: any) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...headers, "Content-Type": "application/json" },
      status: 400,
    });
  }
});
