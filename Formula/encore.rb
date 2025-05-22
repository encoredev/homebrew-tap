class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.47.2"
    checksums = {
        "darwin_arm64" => "d17158313a3b399d3751b152d5d2f78056e0fca8935a3e68813f0cd9c392fc39",
        "darwin_amd64" => "9c1b3226be15e352790e69d00055a789369db0374953fdedc72aa2d0a6f7b420",
        "linux_arm64"  => "e4331dfe5d59dd96a44fd221056e9beca68d524ba21561559b28fee204b6ec1c",
        "linux_amd64"  => "1b28be74b085222168ec8ca76e3059545f91dba37a854dfb5415c7fc47e8145b",
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
