___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "CookieTractor Consent State",
  "categories": ["TAG_MANAGEMENT", "PERSONALIZATION", "ANALYTICS"],
  "description": "CookieTractor is the user-friendly CMP (Consent Management Platform) that complies with WCAG 2.2 accessibility requirements. For more information visit https://www.cookietractor.com.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "label1",
    "displayName": "\u003cb\u003eCheck Consent State\u003c/b\u003e\u003cbr/\u003e\nUse this variable to check for visitor e.g. with trigger conditions. The variable contains a comma separated list of given consents.\u003cbr/\u003e\u003cbr/\u003e\u003cb\u003eExample:\u003c/b\u003e marketing,statistical,functional,necessary\u003cbr/\u003e\n\u003cbr/\u003e\nTo check for marketing-consent, use a condition like this: {CookieTractor - Consent State} contains marketing\u003cbr/\u003e\n\u003cbr/\u003e\nAvalible categories:\u003cbr/\u003e\n\u003cbr/\u003e* marketing\u003cbr/\u003e* statistical\u003cbr/\u003e* functional\u003cbr/\u003e* necessary\u003cbr/\u003e\n\u003cbr/\u003e\nVisit our documentation for more information:\u003cbr/\u003e https://www.cookietractor.com/setup-instructions/google-tag-manager\u003efoo"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const log = require('logToConsole');
const getCookieValues = require("getCookieValues");
const JSON = require('JSON');
const decodeUri = require('decodeUri');
const decodeUriComponent = require('decodeUriComponent');

const LOG_PREFIX = 'CT.CMP > ';

/* Functions */

function parseConsentCookie(cookieValue) {
    if(!cookieValue)
        return {consents : []};
    let isLegacyEncoding = cookieValue.indexOf(',') > -1;
    let decoded = isLegacyEncoding ? decodeUri(cookieValue) : decodeUriComponent(cookieValue);
    let parsed = JSON.parse(decoded);
    return parsed;
}

/* Script */

var consentCookies = getCookieValues('_cc_cookieConsent');

if(consentCookies && consentCookies.length > 0){
  
  let cookieData = parseConsentCookie(consentCookies[0]);
  cookieData = cookieData.filter(x=> x != 'undefined');
  
  log(LOG_PREFIX,'consents',cookieData.consents);
  
  return cookieData.consents.join(',');
}

return '';


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "_cc_cookieConsent"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Should return false
  code: |-
    const mockData = {
      // Mocked field values
      consentType : 'marketing'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
    assertThat(variableResult).isEqualTo(false);


___NOTES___

Created on 3/1/2024, 3:10:23 PM


