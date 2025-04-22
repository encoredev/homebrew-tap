class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.20"
    checksums = {
        "darwin_arm64" => "18e1da53e7633513b9587b0347b786a2b07d09c1036b0ac9769362a7e244178c",
        "darwin_amd64" => "358bb5b95d9585ee17bb3cac359266aad09706344eb8de20e667cd803286aa35",
        "linux_arm64"  => "cf0acafc611ba354567f5e86cbf930d0fc5dea0bba15281a958ed71f5f5e77c7",
        "linux_amd64"  => "67b52e914e833d06bc70a44494ea69aebe4ae5a76101e0e22db8d800b5233f72",
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
