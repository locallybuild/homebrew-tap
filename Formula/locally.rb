class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.11.04"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "54c5c55f3cfc69b96cbca22ab986a9791d3fd9cdb249acd110c6fc6e3193ef0a"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "0ab61b0ab6ac1c9900884a6a7d84b62cd4e3d7315687018c67925d9a554d3647"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "7498642184761ba54a08b56cbe1a72d4ac2494a470a03a101db84dfce39365a0"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "333f1d0c289c43cc2b4466eec4b449e2fbd5a12a6cec40e319727c6c8f1cd8e5"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
