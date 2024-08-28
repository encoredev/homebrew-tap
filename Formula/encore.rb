class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.39.7"
    checksums = {
        "darwin_arm64" => "d9614fcadcaa285c54128fc5900bb85dc111da36aa227cb1181a7688c6a0d93e",
        "darwin_amd64" => "67be204ff3d0ca708910b0d188f31b056d036330acd53dc9beecf84588881332",
        "linux_arm64"  => "bd4a4047aa03cb06f8a67ef0405baaabb5758f48f1eaf4764466da1c8ac9e1f9",
        "linux_amd64"  => "baecf812ecdf66a0704bf69a401a4e5adabfabd59a6d670785182ac8fe094f8d",
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
