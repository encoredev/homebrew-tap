class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.10"
    checksums = {
        "darwin_arm64" => "dde3070ebf603eb3aa1aab9c1a14c92f61323a017981d41e56634b19c86ce231",
        "darwin_amd64" => "be482434871040ec47c4a80e5fee84ae3700657211db457bfe42f569492c6679",
        "linux_arm64"  => "857cc1c902aa7416eea6cded8d58b08509d3cdf10bd1d747896f771b7d66be61",
        "linux_amd64"  => "b9f7627d1d59e6fae89d7468e16843e4007194f340b6cc8c4e7c128e443d73ac",
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
