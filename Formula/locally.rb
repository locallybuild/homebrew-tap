class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.11.03"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "2d56e2a343282f252f46ae3f507b447d867b858604d1779e87b53b22c8dc90da"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "4579c99eb0aad58966c0af1b233c19689be7b4553a134abbac4c68bc0e0b5fa9"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "0c73077a733609d8b8ef7c9eca71aa9966883707cacd2f9ff91dc21ffa88d916"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "4c3933124b0798802399e8b95d3444ad9ab8f9a190b2b13b68f7f32ac1ffd76c"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
