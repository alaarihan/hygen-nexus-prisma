---
to: app/models/<%= name %>.ts
sh: "<%= !noPrettier ? `npm run prettier` : '' %>"
---

import { objectType, arg, extendType } from 'nexus'
export const <%= name %> = objectType({
  name: '<%= name %>',
  definition(t) {
    <% prismaModel.fields.forEach(function(field){ -%>
    t.model.<%= field.name %>()
    <% }); %>
	},
})

export const <%= h.changeCase.camel(name) %>Query = extendType({
  type: 'Query',
  definition(t) {
    t.crud.<%= h.changeCase.camel(name) %>()
    t.field('findFirst<%= name %>', {
      type: '<%= name %>',
      args: {
        where: '<%= name %>WhereInput',
        orderBy: arg({ type: '<%= name %>OrderByInput' }),
        cursor: '<%= name %>WhereUniqueInput',
        skip: 'Int',
        take: 'Int',
      },
      async resolve(_root, args, ctx) {
        return ctx.prisma.<%= h.changeCase.camel(name) %>.findFirst(args as any)
      },
    })
    t.crud.<%= h.inflection.pluralize(h.changeCase.camel(name)) %>({ ordering: true, filtering: true, })
    t.field('<%= h.inflection.pluralize(h.changeCase.camel(name)) %>Count', {
      type: 'Int',
      args: {
        where: '<%= name %>WhereInput',
      },
      async resolve(_root, args, ctx) {
        return ctx.prisma.<%= h.changeCase.camel(name) %>.count(args as any)
      },
    })
  },
})

export const <%= h.changeCase.camel(name) %>Mutation = extendType({
  type: 'Mutation',
  definition(t) {
    t.crud.createOne<%= name %>()
    t.crud.updateOne<%= name %>()
    t.crud.upsertOne<%= name %>()
    t.crud.deleteOne<%= name %>()
    t.crud.updateMany<%= name %>()
    t.crud.deleteMany<%= name %>()
  },
})
