class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230321"
    checksums = {
        "darwin_arm64" => "87824f66793c776636e95d024e2cf5295038dc49de5f382ddd619c6715848d58",
        "darwin_amd64" => "346ab4db8105bd24638d60a0c15f6cdfa888e0dfbccb60c33c7fe279faa18c19",
        "linux_arm64"  => "bab0d795d7dfedb42aabccb6fc0954d5072e2b34796f2876bea330ccd2604149",
        "linux_amd64"  => "1dbd6702029f386489f7382f08d45af58e2cd9f5bd2c4b0b801a4bd61befdfdc",
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
