class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.09"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "f4fa03124797b556f34e744ac0930a95f14766941b30e28b6e8793314e4b2a8c"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "e20883fe79edad8865f6090d091ce45398cc291b2f91b30530615206bb37d25a"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "c591bec6c726a3925e4ed6ae3737c596564d526a93813d56b6ffabbe9a41f620"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "d59ca52cf02c53657ef26757864f00ccb5787e763cc01a627e5ced5da6742ec4"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
