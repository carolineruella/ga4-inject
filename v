export default {
  async fetch(request, env) {
    const response = await fetch(request);
    const contentType = response.headers.get("content-type") || "";

    if (!contentType.includes("text/html")) {
      return response;
    }

    const html = await response.text();

    const ga4Script = `
<!-- Google Analytics 4 -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-3YRLPCV52W"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-3YRLPCV52W');
</script>`;

    const newHtml = html.replace('</head>', ga4Script + '</head>');

    return new Response(newHtml, {
      headers: response.headers,
    });
  },
};