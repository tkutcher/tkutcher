module.exports = {
  root: true,
  overrides: [
    {
      files: ["*.ts"],
      extends: ["plugin:@angular-eslint/recommended", "prettier"],
      parser: "@typescript-eslint/parser",
      parserOptions: {
        tsconfigRootDir: __dirname,
        project: "./tsconfig.json",
      },
      rules: {
        "max-len": [
          "error",
          {
            code: 88,
            comments: 86,
            ignoreUrls: true,
            ignoreTemplateLiterals: true,
            ignorePattern: "^import\\s.+\\sfrom\\s.+;$",
          },
        ],
      },
    },
    {
      files: ["*.html"],
      extends: ["plugin:@angular-eslint/template/recommended"],
    },
  ],
};
