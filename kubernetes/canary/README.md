# Canary Deployment

When hosting SPA applications, you should not balance requests based on a percentage of all requests. This may lead to inconsistent behavior for particular users. Instead you should leverage the NGINX Ingress `canary` annotations to implement A/B deployments based on information available in every request.

This sample routes all users using *Microsoft Edge* to the `preview` version of the app, whereas all other users will be routed to the `regular` version of the app. Responsible for the canary routing capabilities are both `Ingress` resources. See [regular/ingress](regular/ingress.yml) and [preview/ingress](preview/ingress.yml).
