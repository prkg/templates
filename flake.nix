{
  description = "A collection of flake templates";

  outputs = { self }: {

    templates = {

      trivial = {
        path = ./trivial;
        description = "A very basic flake";
      };

      "lisp/sketch" = {
        path = ./lisp/sketch;
        description = "Common Lisp with Sketch for generative art";
      };

    };

    defaultTemplate = self.templates.trivial;

  };
}
