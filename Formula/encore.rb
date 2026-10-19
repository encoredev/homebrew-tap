class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.58.7"
    checksums = {
        "darwin_arm64" => "786dbd6cee3d0bc6b322ca61852fbd27d355e736a879a01c7b5731e93308fdba",
        "darwin_amd64" => "4fd1c9793991daee9ada3212216d19b53d7d72fc10850281aee864c427006bd2",
        "linux_arm64"  => "3eab6770403c13e1d654076cee3bb3a7f64f38c6575563bf68ab285f320c372c",
        "linux_amd64"  => "09ae05a370a76386af94b5010a9043b86c7661c25c6572369c1209bc66c0c39e",
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
