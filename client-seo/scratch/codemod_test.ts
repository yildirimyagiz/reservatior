import { Project, SyntaxKind, JsxText, Identifier } from "ts-morph";

const project = new Project();
project.addSourceFilesAtPaths("../src/app/[locale]/admin/properties/AdminPropertiesPage.tsx");

const sourceFile = project.getSourceFiles()[0];

sourceFile.getDescendantsOfKind(SyntaxKind.JsxText).forEach(textNode => {
    const text = textNode.getLiteralText().trim();
    if (text && /[a-zA-Z]/.test(text) && text.split(' ').length <= 10) {
        console.log("Found JSX Text:", text);
    }
});

