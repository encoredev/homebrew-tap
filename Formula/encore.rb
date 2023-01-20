class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.13.0"
    checksums = {
        "darwin_arm64" => "0f2fc9b717047124f233cdbbcb94dbad88272d0db842961deea8ee19aff96b42",
        "darwin_amd64" => "8df817f432339d877b4f0f947e2ccd69697460d3fc78afcb6f46f03f3df95c4b",
        "linux_arm64"  => "74c73e070f9c286214e03e08a53e948e84c0b13e2dd7b25831bcb09165b3b420",
        "linux_amd64"  => "014f5e344a8a79cdbf7367697246eaccca44747911d5695ed9515fa85fbe8e5b",
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
