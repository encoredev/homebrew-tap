class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.21.2"
    checksums = {
        "darwin_arm64" => "f8490f2b583118f632d630e4414dad9140790f9f031fab63c535106cae9faea4",
        "darwin_amd64" => "e81f24061a6c61800a7b7ded29fa918222cf34a056eb47c817b22b3747c3cf59",
        "linux_arm64"  => "baa1dd3b95d310b1a470372d1944596e887beb7f002357af15105b33892b0831",
        "linux_amd64"  => "34727f4251b1b5478c1af3cc6f8822255a7af8ad4f1af8bf945c6583c9a3744d",
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
