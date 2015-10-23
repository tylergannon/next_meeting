module SpecMacros
  def validates_presence_of! *args
    args.each do |arg|
      it {is_expected.to validate_presence_of(arg)}
    end
  end
end
