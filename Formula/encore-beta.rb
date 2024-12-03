class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.9-beta.2"
    checksums = {
        "darwin_arm64" => "6ba79736ea32dccdc80929cb6532abc8f80f4b3c761ff63c0dcb61bc55eb72cf",
        "darwin_amd64" => "c4b45dd9b5ad59dce60bbf203b9041d6a58dee3beb193fde32d72be1d10b8c27",
        "linux_arm64"  => "9a58d7e87ac435e52110229f3ed4c18dccd21611d65d3057f4ba231b9e30d901",
        "linux_amd64"  => "f9202df3a0e180712111cda5142ee7a9c11e27bfbaa3d6a17b623d30c515d0fc",
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
