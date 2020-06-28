---
title: Privacy Policy
layout: page
permalink: /privacy/
banner_type: small
date: 2020-06-28
privacy_local_storage: acceptedPrivacyPolicyDate
---

This Privacy Policy is meant to help you understand what information this website collect and why it collect it. This page also allows also to check and update your privacy settings on this website.

# Privacy settings

{% include privacy-settings.html %}

# About cookies and local storage

Like many other websites, this website and the included third party content rely on storing data in cookies and browser's local storage.

## Cookies

According to [Wikipedia](https://en.wikipedia.org/wiki/HTTP_cookie), an HTTP cookie (also called web cookie, Internet cookie, browser cookie, or simply cookie) is a small piece of data sent from a website and stored on the user's computer by the user's web browser while the user is browsing. Cookies are sent to their originating server on each request made by the browser.

## Local storage

According to [Wikipedia](https://en.wikipedia.org/wiki/Web_storage), browser's local storage can also contain data but is only available for client-side scripting. The data available in local storage is not automatically transmitted to the server in every HTTP request. However, this can be achieved with explicit client side scripts.

# Essential

## Cloudflare _cfduid cookie

This website is served through Cloudflare CDN infrastructure and therefore requires the use of `_cfduid` cookie.According to [Cloudflare documentation](https://support.cloudflare.com/hc/en-us/articles/200170156-Understanding-the-Cloudflare-Cookies#12345682.):

The `_cfduid` cookie helps Cloudflare detect malicious visitors to our Customers’ websites and minimizes blocking legitimate users. It may be placed on the devices of our customers' End Users to identify individual clients behind a shared IP address and apply security settings on a per-client basis. It is necessary for supporting Cloudflare's security features.

The `_cfduid` cookie collects and anonymizes End User IP addresses using a one-way hash of certain values so they cannot be personally identified. The cookie is a session cookie that expires after 30 days.

The `_cfduid` cookie does not:

- allow for cross-site tracking,
- follow users from site to site by merging various `_cfduid` identifiers into a profile, or
- correspond to any user ID in a Customer’s web application.

Read more on [Cloudflare website](https://support.cloudflare.com/hc/en-us/articles/200170156-Understanding-the-Cloudflare-Cookies#12345682.)

## Cookieless anonymized Google Analytics

This website relies an Google Analytics to gather analytics data, it has been configured to avoid collecting personal data by disabling cookies, not storing end user id and anonymizing IP addresses.

Following Google Analytics documentation about [their use of cookies and how to identify users](https://developers.google.com/analytics/devguides/collection/analyticsjs/cookies-user-id#disabling_cookies), all of their cookies have been disabled and no end user identifier (named `clientId`) is sent to Google nor stored anywhere.

Also, following Google Analytics documentation, IP addresses are [anonymized](https://support.google.com/analytics/answer/2763052?hl=en) when collecting analytics data.

# Optional

## Privacy policy banner toggler in local storage

In order to avoid showing the privacy message on each visit, this website can store the privacy policy's effective date in a `{{page.privacy_local_storage}}` value when privacy banner is dismissed. If privacy policy should evolve, the privacy banner will be shown again.

## Embedded third party content cookie or local storage

Some pages of this website may contain embedded content hosted by third parties (listed below). Such content will be loaded only if you choose to see it. By showing such third party content, you accept this third party privacy policy. You may also choose to store your choice in browser's local storage.

{% include thirdparties.html %}


