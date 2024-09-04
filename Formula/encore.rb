class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.40.2"
    checksums = {
        "darwin_arm64" => "4d62ba7ecc44b88bfb514312ef73a1e3eddffed3530bd8da45c7ef6e847d1660",
        "darwin_amd64" => "63db39810530d57f297e15340fdee377d59310b4dc258a5de231ddb1e0b30d71",
        "linux_arm64"  => "5079b4fea08a436541a6550a100ced6fbc7cbac67c8d83f09fe32fa62b9ba878",
        "linux_amd64"  => "98c2bb0cb7642caef500eabbb931f1d65421436f19295bb7f8f0a5573a7dfb2d",
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
