# Liquibase Exit Code Test Repository

This repository tests exit code behavior differences between Liquibase 4.33 and 5.0.0 when used with `setup-liquibase@v2`.

## Issue Description

When using setup-liquibase v2 with Liquibase 5.0.0, workflow steps show as successful (green checkmark) even when Liquibase commands fail and throw exceptions. This behavior differs from Liquibase 4.33 which properly propagates exit codes.

## Repository Structure

```
.
├── actions/
│   └── setup-liquibase/
│       └── action.yml          # Composite action wrapper
├── .github/
│   └── workflows/
│       └── test-exit-codes.yml # Test workflow comparing 4.33 vs 5.0
├── changelog.xml                # Simple test changelog
├── liquibase.flowfile.yaml     # Flow file with stages that will fail
└── README.md                    # This file
```

## Setup Required

Before running the workflow, add the following secret to your repository:

- `LIQUIBASE_LICENSE_KEY` - Your Liquibase Secure edition license key

## Expected Behavior

**Liquibase 4.33:**
- PolicyChecks stage should fail with red X
- DriftDetection stage should fail with red X
- Workflow should fail overall

**Liquibase 5.0.0:**
- Stages show green checkmarks despite exceptions
- Workflow shows as successful despite failures
- Exit codes are not properly propagated

## Running the Test

1. Push this repository to GitHub
2. Add the `LIQUIBASE_LICENSE_KEY` secret
3. Trigger the workflow manually or push to main branch
4. Compare the results between the two jobs

## Related

- Parent Repository: [liquibase/setup-liquibase](https://github.com/liquibase/setup-liquibase)
- Issue: Exit code handling difference between Liquibase 4.33 and 5.0.0
