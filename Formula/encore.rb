class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.58.3"
    checksums = {
        "darwin_arm64" => "da4c20b0b06ebd03e5ddb6cedf4f569f43d9c8415372b44f81d5523a24a2bd03",
        "darwin_amd64" => "995a022f7e6716f3aaea6d5a91042d7442ba4987884ac33f3d91e84f71132642",
        "linux_arm64"  => "95f58c431d337b5725430fc76e896da802aebbce142434ffb6ec2864cfc7aa97",
        "linux_amd64"  => "800bfa1b6d7cbbc6b85c7b990cbb9e3cc3645451bce98129f34c53280d8f2c9a",
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
