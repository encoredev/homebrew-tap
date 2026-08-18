class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.58.2"
    checksums = {
        "darwin_arm64" => "d53a7c450f8299fa1534de3282058808550180bd468774403bc045f618fbb72c",
        "darwin_amd64" => "5237912f019b35a9768c6315cdfd9b8b03bad28bbc874205aee1a12d86bf924d",
        "linux_arm64"  => "76b779460d36d76b23f5c83f5823d6833064fea758b7a70fa3eba27fd842da09",
        "linux_amd64"  => "f5f140fa8c5d914f9467f2ed4f8582efda77aac401eb1e141277600a602ca7fd",
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
