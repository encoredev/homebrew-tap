class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.56.8"
    checksums = {
        "darwin_arm64" => "a00a98d8f6deae9f9c63d773156df655ab74ba4d560b99bf0c246476a2055992",
        "darwin_amd64" => "ca4874cc62388bc872c721d66d17bf8ac9c99d54f5afdb9ae6d677907c23bbe9",
        "linux_arm64"  => "7cdc2011017dbdf03dc001db9bf3f5688619a967c0b23ec7171193e40dab8c80",
        "linux_amd64"  => "05a2dbb26c3cffa49629087ac07b60a9e2911843e5164d6b7e1399d752456d49",
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
