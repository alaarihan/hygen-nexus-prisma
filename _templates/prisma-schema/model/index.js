const { dmmf } = require('@prisma/client');
const dataModel = dmmf.datamodel;
module.exports = {
    params: ({ args }) => {
      const prismaModel = dataModel.models.find((item) => item.name === args.name);
      if(args.noPrettier === undefined){
        args.noPrettier = false
      }
      return { ...args, prismaModel }
    }
  }