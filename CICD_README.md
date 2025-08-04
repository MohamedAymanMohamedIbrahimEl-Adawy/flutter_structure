// base64 -i "secrets/Certificates.p12" -o ios_certificate.txt

// base64 -i ios/Runner/firebase/stage/GoogleService-Info.plist > stage.base64.txt
// base64 -i android/app/google-services.json > google-services.base64.txt

// base64 -i android/firebase-service-account.json > firebase-service-account.base64.txt

// base64 -i "secrets/IOS_PROVISIONING_PROFILE_DEV.mobileprovision" -o dev-provisioning.txt

// base64 -i "secrets/IOS_PROVISIONING_PROFILE_PROD.mobileprovision" -o prod-provisioning.txt

// base64 -i "secrets/IOS_PROVISIONING_PROFILE_STAGE.mobileprovision" -o stage-provisioning.txt

// base64  ios/Runner/firebase/stage/GoogleService-Info.plist > stage.base64.txt
base64 -i AuthKey_8WRA29VZD8.p8 > auth.base64.txt