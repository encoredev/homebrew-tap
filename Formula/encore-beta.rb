class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.33.5-beta.6"
    checksums = {
        "darwin_arm64" => "d105ef1e2c006e253b37a157da3aeb11327a5b7a782ee1746cbc1a0451c793bb",
        "darwin_amd64" => "593cf88ade79758e5180be51db520402ce2a2a041ea48abe884d1bf9407293ca",
        "linux_arm64"  => "dce7957df58deaebd463f49a9f8b518b0d061f84d7fc6047d8fb72ea72f1a06c",
        "linux_amd64"  => "7fbeee6c685dcbafc8accb466d574d9797796fb941b4ef9f36b61ed21793553c",
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
