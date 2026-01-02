class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.53.3"
    checksums = {
        "darwin_arm64" => "582625bc6bbe9383274ee26e0de6c627dbf53d6336725a2aeaf330d519e1ae83",
        "darwin_amd64" => "104128902a8fce35f477c8a7874553199fa3eb49143146bc2d15a1ea0813b934",
        "linux_arm64"  => "f4f85e711f7681a9d6b4dbb56e8684d05e20999dfc724a7e0b64da2735a93e66",
        "linux_amd64"  => "b608189fd07732cb258d934b9658401c0651823a736fb745ed6bbd4de1e231da",
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
