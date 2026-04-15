require "pathname"

RSpec.describe "Job boundaries" do
  let(:root) { Pathname.new(File.expand_path("../..", __dir__)) }

  it "does not allow raw external IO inside jobs" do
    job_files = Dir[root.join("app/jobs/**/*.rb")]
    next skip("no jobs found") if job_files.empty?

    offenders = job_files.select do |file|
      File.read(file).match?(/Net::HTTP|Faraday|HTTParty|RestClient|HTTP\.|Excon|Typhoeus/)
    end

    expect(offenders).to be_empty, <<~MSG
      Jobs should not perform raw external IO directly.
      Offenders:
      #{offenders.join("\n")}
    MSG
  end
end
