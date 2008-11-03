Gem::Specification.new do |s|
  s.name = %q{petticoat_junction}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tyler McMullen"]
  s.date = %q{2008-11-03}
  s.description = %q{Framework for periodically searching for terms on multiple services.}
  s.email = %q{tbmcmullen@gmail.com}
  s.homepage = %q{http://github.com/tyler/petticoat_junction}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Framework for periodically searching for terms on multiple services.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<metaid>, [">= 0"])
      s.add_runtime_dependency(%q<starling-starling>, [">= 0"])
    else
      s.add_dependency(%q<metaid>, [">= 0"])
      s.add_dependency(%q<starling-starling>, [">= 0"])
    end
  else
    s.add_dependency(%q<metaid>, [">= 0"])
    s.add_dependency(%q<starling-starling>, [">= 0"])
  end
end
