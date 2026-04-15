require "pathname"

RSpec.describe "Domain boundaries" do
  let(:root) { Pathname.new(File.expand_path("../..", __dir__)) }

  it "does not allow Catalog to depend on Orders directly" do
    catalog_files = Dir[root.join("app/domains/catalog/**/*.rb")]
    next skip("no catalog domain found") if catalog_files.empty?

    offenders = catalog_files.select do |file|
      File.read(file).match?(/\bOrders::/)
    end

    expect(offenders).to be_empty, <<~MSG
      Catalog should not depend directly on Orders.
      Offenders:
      #{offenders.join("\n")}
    MSG
  end
end
