export const EnvProtection = async (ctx) => {
  return {
    "tool.execute.before": async (input, output) => {
      if (input.tool === "bash") {
        if (input.tool === "read" && output.args.filePath.includes(".env")) {
          throw new Error("Do not read .env files")
        }
      }
    },
  }
}