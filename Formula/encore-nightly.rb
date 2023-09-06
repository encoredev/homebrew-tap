class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230906"
    checksums = {
        "darwin_arm64" => "bdff356f38dc838b1a495b8bfd84b118e81c6f9655051b094220c7a266a5b2c3",
        "darwin_amd64" => "a2e9a7d2534a75255c7d964c9455cd446880e9faea5338d90dc8847ce9e71e00",
        "linux_arm64"  => "fee7b5e16449280a4f3d1d566329e392ad02ea7ca15b7fc32fb8cecb15fdb741",
        "linux_amd64"  => "f3ff8a34368fbf1bf0b9ebc4cdf20af1125ab09749a96d8cc02c4b0022b2c1a8",
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
