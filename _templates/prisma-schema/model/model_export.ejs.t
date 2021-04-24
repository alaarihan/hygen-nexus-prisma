---
inject: true
to: app/models/index.ts
append: true
skip_if: "'./<%= name %>'"
---

export * from './<%= name %>' 