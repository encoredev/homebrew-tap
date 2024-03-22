class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.3-beta.3"
    checksums = {
        "darwin_arm64" => "5a07f574e08fa69494e95725ddf56fb47d2d8f83f3ed6b04eb293c6465add141",
        "darwin_amd64" => "51cd44e2e90740e939fa47d3045737ccd3f29ae377ec68198f7c0fbb653956a8",
        "linux_arm64"  => "aa0070540bb8a13b75d45241c07d55603af67d6859d9ff1136bdded89425cf66",
        "linux_amd64"  => "b385909aa659212c33e515f004a1f15db541e6ecd8f17698ff83089ee9f37fef",
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
