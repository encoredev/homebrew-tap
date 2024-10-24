class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.42.4"
    checksums = {
        "darwin_arm64" => "fdbc7d0f66da0b959b2227f82710f4211623b0d4bf2ad46fd2a77f1101c5dbe9",
        "darwin_amd64" => "2197b3f7c0e16ec44bb2d3201797fafa50d7b3a77fd7630f543425fdccc2cbb6",
        "linux_arm64"  => "00a8091a2e82715a8975db68549fdbfe646afc134701711058cace9dcc632f5d",
        "linux_amd64"  => "f60030bfa370e22ad2481fea0f128bb0cacf701c26f0b007f3c359aa010492d5",
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
