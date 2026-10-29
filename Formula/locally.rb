class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.10.01"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "450ac6640e8ff2e77f388b557c2c234010ef34a5eec9d8d81b54eea6564ba291"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "5ee2b0a6521c57472a0eb5c884bb3e3210abcb4fc5ddeb3a7b605176d32630b5"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "a931666a47273a5174db8e5be0eead90fb9d3662532491294bc044ee01b46a45"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "0d147e66a473200221eb0398482882b0413fdeced30742eb17129870d1b3612d"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
