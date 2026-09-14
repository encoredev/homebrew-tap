# Releaser replaces this formula on the first alpha publication.
class EncoreAlpha < Formula
  desc "Encore v2 alpha CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"
  head "https://github.com/encoredev/v2-encore.git", branch: "v2"

  disable! date: "2026-09-14", because: "has no published alpha release yet"

  def install
    odie "No alpha release has been published yet"
  end
end
