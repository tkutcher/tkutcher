
## Set Up Angular Universal

1. `ng generate universal --client-project=<name_of_project>` (e.g. name of project could be zpdsolutions-dot-com
2. Fix up app.server.module.ts:
```ts
@NgModule({
  imports: [
    FlexLayoutServerModule,
    AppModule,
    ServerModule,
    NoopAnimationsModule
  ],
  bootstrap: [AppComponent],
})
export class AppServerModule {}
```
3. `npm install angular-prerender --save-dev`
4. `ng build --prod` to build dist
5. `ng run <name_of_project>:server` to compile server main
6. `npx angular-prerender` to prerender files for that
7. The artifacts to serve are in `dist/<name_of_project>/bro`

Notes:
- Might need to fix up versions in the package.json
- Need to guard things like `document` and `sessionStorage` with `isPlatformBrowser` (see https://stackoverflow.com/questions/50018289/error-document-not-defined-on-build-angular-universal-app)

