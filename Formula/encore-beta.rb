class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.3-beta.4"
    checksums = {
        "darwin_arm64" => "5b6f50c0c4da450f346f8ca679daebc54d83fdba49db38c7183fbb9dde4f1b86",
        "darwin_amd64" => "414a9e9ffa4ca8c4a391cf2ccce611c07bdcc6386646530eff7368e6ded6dc01",
        "linux_arm64"  => "202784f08ffe2030d39c22c897fe60caedbedb96070bd463330dec925f9adb0e",
        "linux_amd64"  => "45f917dfef9ba816b725eaabba2813c7f288203c8e2ec60ed953d5b06c2b7d36",
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
