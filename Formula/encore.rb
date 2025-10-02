class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.50.3"
    checksums = {
        "darwin_arm64" => "58f2e22171b342636385c70fdad3ce37c4db0fe1f9006bdd0e9b2885e0d9b2cd",
        "darwin_amd64" => "d18d35a72f038e1891708a30943cdaa5864ccfd0b0def96e590987f689f79099",
        "linux_arm64"  => "d2b120a5951e85132321a1200dabadd84c943cd1f94c7c0b104d10f57d5f9953",
        "linux_amd64"  => "7ed96e2743a664b107de719dadabde1496056b77abd40e98d2fee7f59780588d",
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
