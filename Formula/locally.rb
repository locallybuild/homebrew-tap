class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.11.01"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "ba89d215dce65fcffbc4e0c7a5e40a4190516e2888addf2ff0623c710b0fbacb"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "2f021a3a7b476b1b6a52f2d018c6d9c5edb912774586409e63c466f61ca0e522"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "303e3824efd53200e72ef6f4e5021a52c6b68e03fe828136a8ce143022d7ef02"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "73884b69202481ca545d8cdf491d8876674b5609621b39dda83ee32933a45d11"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
