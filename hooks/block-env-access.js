process.stdin.setEncoding("utf8");
let input = "";
process.stdin.on("data", (d) => {
  input += d;
});
process.stdin.on("end", () => {
  const { tool_name, tool_input } = JSON.parse(input);

  const path = tool_input?.file_path || "";
  const cmd = tool_input?.command || "";

  // Block .env files but allow .env.example
  const hitsEnv = (s) =>
    /(?:^|\/)\.env(\.|$)/.test(s) && !/(?:^|\/)\.env\.example$/.test(s);

  if (hitsEnv(path) || (tool_name === "Bash" && hitsEnv(cmd))) {
    console.error("You cannot read the .env file");
    process.exit(2);
  }

  process.exit(0);
});
