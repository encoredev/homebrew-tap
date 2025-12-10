class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.52.4"
    checksums = {
        "darwin_arm64" => "e02df5f58dd6cd4951a21e40d983751362f3d103bd9c912bc356be01b7788b66",
        "darwin_amd64" => "d376dd55eb783838053855487c629a770784df37156b698f30d1667c8879c062",
        "linux_arm64"  => "bdb0c84fed69581a3dd409de7b3b2a85249648fadf444dfccee7084e845cdd2a",
        "linux_amd64"  => "e9099f98e28ec827bed997663d311c4e503a76942b79346e395d49779a46cdf7",
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
