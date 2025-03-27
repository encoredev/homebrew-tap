class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.14"
    checksums = {
        "darwin_arm64" => "af6724499098f9be49a0b18d921f6a8f3b3fd0bcd0730b342d621d56bbb841fe",
        "darwin_amd64" => "61630e99bc5a8439a5fe457a0e1238197c4650d23940d7bf705bad8b614bbc42",
        "linux_arm64"  => "2410cb2a5a422d07e476a54b5906fe78d51e4e66c85595f10e8a93a3fd43bc6e",
        "linux_amd64"  => "993982a9e978f5205eb748a2bfc4edafd79b1ebe8cf1e3af55a7c12ad5d4c1d2",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
