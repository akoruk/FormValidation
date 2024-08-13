# Validator Framework for SwiftUI

This repository contains a SwiftUI-based framework designed for validations of text, dates and selections. It also includes string formatters.

## Features

- **String Validator**: Validates strings for required input, email and phone formats, and more. See StringValidationRule
- **Date Validator**: Checks dates against conditions such as minimum and maximum values, specific periods, and age requirements. See DateValidationRule
- **Selection Validator**: Validates selections if it is nil or not. See SelectionValidationRule
  
- **String Formatter**: Applies formatting automatically to text fields for structured inputs like phone numbers and credit cards. See StringFormationRule

## Installation

To get started with the Validator Framework, integrate it into your SwiftUI project with the following options:

- **Swift Package Manager (SPM)**

```bash
  https://github.com/akoruk/formvalidation.git
```

#### String Validation Rules

```bash
case required(ValidationResult)
case email(ValidationResult)
case phone(Int, ValidationResult)
case min(Int, ValidationResult)
case max(Int, ValidationResult)
case equal(String, ValidationResult)
case existsIn([String], ValidationResult)
case notExistIn([String], ValidationResult)
case regex(String, ValidationResult)
case creditCard(ValidationResult)
case url(ValidationResult)
case strongPassword(ValidationResult)
case nonEmptyWhenTrimmed(ValidationResult)
case numerical(ValidationResult)
case alphabetical(ValidationResult)
case alphanumerical(ValidationResult)
case inCharset(CharacterSet, ValidationResult)
```

#### Date Validation Rules

```bash
case required(ValidationResult)
case min(Date, ValidationResult)
case max(Date, ValidationResult)
case equal(Date, ValidationResult)
case inTheSamePeriod(Date, Calendar.Component, ValidationResult)
case minAge(Int, ValidationResult)
case maxAge(Int, ValidationResult)
```

#### String Formation Rules

```bash
case max(Int)
case phone(String)
case creditCard(String)
case email
case filter(allowedCharacters: String)
```
