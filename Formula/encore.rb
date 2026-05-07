class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.57.0"
    checksums = {
        "darwin_arm64" => "ee5e230d5fb73ce46a83d73b0ea4d3bf1e2a4d95be0d6a7234e0dd4bc6fd269c",
        "darwin_amd64" => "fdb611d49a6571e9f401ec7d52f0412c6dec648b50c2e6a67cc88d3bb18b0715",
        "linux_arm64"  => "b0372446452e7e09f764497443e3fd7445a71a9fafae5a296abee997b15118b6",
        "linux_amd64"  => "07af76731c3cdeb348271085220ad7f1059a6313bdffebb385a1a864b2343e5b",
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
