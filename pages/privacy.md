---
title: Privacy Policy
layout: page
permalink: /privacy/
banner_type: small
date: 2020-04-07
---

This Privacy Policy is meant to help you understand what information this website collect and why it collect it.
TL;DR; This website do not collect any personal data and do not use any commercial tracking cookie.

# Cookies

According to [Wikipedia](https://en.wikipedia.org/wiki/HTTP_cookie), an HTTP cookie (also called web cookie, Internet cookie, browser cookie, or simply cookie) is a small piece of data sent from a website and stored on the user's computer by the user's web browser while the user is browsing. 

This website uses a single cookie named `_cfduid` which cannot identify nor track users.

## Cloudflare _cfduid cookie

This website is served through Cloudflare CDN infrastructure and therefore requires the use of `_cfduid` cookie.According to [Cloudflare documentation](https://support.cloudflare.com/hc/en-us/articles/200170156-Understanding-the-Cloudflare-Cookies#12345682.):


The `_cfduid` cookie helps Cloudflare detect malicious visitors to our Customers’ websites and minimizes blocking legitimate users. It may be placed on the devices of our customers' End Users to identify individual clients behind a shared IP address and apply security settings on a per-client basis. It is necessary for supporting Cloudflare's security features.

The `_cfduid` cookie collects and anonymizes End User IP addresses using a one-way hash of certain values so they cannot be personally identified. The cookie is a session cookie that expires after 30 days.

The `_cfduid` cookie does not:

- allow for cross-site tracking,
- follow users from site to site by merging various `_cfduid` identifiers into a profile, or
- correspond to any user ID in a Customer’s web application.

Read more on [Cloudflare website](https://support.cloudflare.com/hc/en-us/articles/200170156-Understanding-the-Cloudflare-Cookies#12345682.)

# Analytics

In order to be able to do browsing statistics such as how many pages have been seen the last 30 days, which pages are the most read or from which countries users come, this website collects anonymized analytics data using Google Analytics.

## Anonymized Google Analytics

This website relies an Google Analytics to gather analytics data, it has been configured to avoid collecting personal data by disabling cookies, not storing end user id and anonymizing IP addresses.

Following Google Analytics documentation about [their use of cookies and how to identify users](https://developers.google.com/analytics/devguides/collection/analyticsjs/cookies-user-id#disabling_cookies), all of their cookies have been disabled and no end user identifier (named `clientId`) is sent to Google nor stored anywhere.

Also, following Google Analytics documentation, IP addresses are [anonymized](https://support.google.com/analytics/answer/2763052?hl=en) when collecting analytics data.

# Other

This website makes use of browser local storage to store privacy policy consent which contains no personal data and cannot be used for tracking.

## Privacy policy toggler

In order to avoid showing the privacy message on each visit, this website stores the privacy policy's effective date in a `{{page.privacy_local_storage}}` value when privacy message is dismissed.
