class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.18"
    checksums = {
        "darwin_arm64" => "60ede1d8aea992bff0a264e7f1648c2beef2e7e389bf42557b48378a91a7821b",
        "darwin_amd64" => "9e57d295517629184b959e2a2126cb1b703e6b08a716dced570a033d30bdf291",
        "linux_arm64"  => "655862058e4427f2262b91af4ed3f3c40c8dd89a1dc5f679aeb7f097802ff262",
        "linux_amd64"  => "d3bf2a6f11cbe003be4eacc0c9da528339d512e79c98c88e6100b5845b61a99f",
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
