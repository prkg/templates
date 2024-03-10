{
  description = "A collection of flake templates";

  outputs = { self }: {

    templates = {

      "simple" = {
        path = ./simple;
        description = "A simple flake";
      };

      "c" = {
        path = ./c/simple;
        description = "Simple C project";
      };

      "lisp" = {
        path = ./lisp/simple;
        description = "Simple SBCL project";
      };

      "lisp/sketch" = {
        path = ./lisp/sketch;
        description = "Common Lisp with Sketch for generative art";
      };

    };

    defaultTemplate = self.templates.trivial;

  };
}
