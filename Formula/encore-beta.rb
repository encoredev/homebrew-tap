class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.32.2-beta.7"
    checksums = {
        "darwin_arm64" => "c6d2ddebd348d1c910cbc86afd9bd6352cdde25adc37ca13d4ed4df80dc1351d",
        "darwin_amd64" => "f5fb5363b0ff362c65553df2f3eda0e9cb6f480d061a8a8b37369889109ea943",
        "linux_arm64"  => "419e99b278c6125eaeedae433c0ea662df07c92a05567b0ee9225c2820291e84",
        "linux_amd64"  => "ff002fed32578f71c4af0d7976dde4fc1dd80553534594f0aaaa233825dbaae0",
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

        bin.install_symlink libexec/"bin/encore-beta"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore-beta").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore-beta").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore-beta.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end
