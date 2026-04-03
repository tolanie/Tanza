//
//  Strings.swift
//  Tannza
//
//  All user-facing strings in one place.
//  To update copy, change it here — no need to hunt through view files.
//

// MARK: - Root

enum Strings {

    // MARK: - Onboarding

    enum Onboarding {
        static let headline         = "Your logistics \n starts here"
        static let subtitle         = "Track, manage, and optimize your logistics operations with ease."
        static let continueButton   = "Continue"
    }

    // MARK: - Sign Up

    enum SignUp {
        static let title            = "Enter your mobile number"
        static let subtitle         = "We'll send you a verification code to confirm your number."
        static let countryCode      = "+234"
        static let phonePlaceholder = "9153065907"
        static let signUpButton     = "Sign up"
        static let disclaimer       = "By proceeding, you consent to get calls, WhatsApp or SMS messages, including by automated means, from LogiFlow and its affiliates to the number provided and hereby agree to our terms and conditions."
        static let orDivider        = "or"
        static let googleButton     = "Continue with Google"
        static let appleButton      = "Continue with Apple"
        static let haveAccount      = "Already have an account?"
        static let signInButton     = "Sign in"
    }

    // MARK: - OTP

    enum OTP {
        /// Heading that includes the user's phone number.
        static func title(phone: String) -> String {
            "Enter the 4-digit code sent to you at \(phone)"
        }
        static let changeNumber     = "Changed your mobile number?"
        /// Resend label that includes the formatted countdown (e.g. "1:00").
        static func resendButton(time: String) -> String {
            "Resend code via SMS (\(time))"
        }
        static let nextButton       = "Next"
    }

    // MARK: - Email

    enum Email {
        static let title            = "Enter your email"
        static let subtitle         = "Add your email to aid in account recovery."
        static let placeholder      = "your email"
        static let validationError  = "Please enter a valid email"
        static let continueButton   = "Continue"
    }

    // MARK: - Setup

    enum Setup {
        static let title                = "Complete your profile"
        static let subtitle             = "Let us know how to properly address you and secure your account."
        static let profilePhotoLabel    = "Profile Photo"
        static let profilePhotoError    = "Profile Photo is required"
        static let fullNameLabel        = "Full Name"
        static let fullNameError        = "Full Name is required"
        static let passwordLabel        = "Password"
        static let passwordError        = "Password is required"
        static let addressLabel         = "Address"
        static let addressError         = "Address is required"
        static let useCurrentLocation   = "Use current location"
        static let completeSetupButton  = "Complete Setup"
    }

    // MARK: - Common

    enum Common {
        static let errorTitle   = "Error"
        static let okButton     = "OK"
    }
}
